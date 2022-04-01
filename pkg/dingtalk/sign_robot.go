package dingtalk

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"time"
)

var RobotURL = url.URL{
	Scheme: "https",
	Host: "oapi.dingtalk.com",
	Path: "/robot/send",
}

type SignRobot struct {
	Token string
	Secret string
}

// url
func (s *SignRobot) geturl() string {
	ts := time.Now().UnixMilli()
	strSign := strconv.Itoa(int(ts)) + "\n" + s.Secret
	hmacCode := hmac.New(sha256.New, []byte(s.Secret))
	hmacCode.Write([]byte(strSign))
	digest := hmacCode.Sum(nil)
	bs64Sign := base64.StdEncoding.EncodeToString(digest)
	sign := url.QueryEscape(bs64Sign)

	v := url.Values{}
	v.Add("access_token", s.Token)
	v.Add("timestamp", strconv.Itoa(int(ts)))
	v.Add("sign", sign)
	RobotURL.RawQuery = v.Encode()

	msgurl := RobotURL.String()
	return msgurl
}

func (s *SignRobot) Send(data string) (error, int) {
	roboturl := s.geturl()
	client := &http.Client{}
	request, err := http.NewRequest("POST", roboturl, strings.NewReader(data))
	if err != nil {
		return err, 400
	}

	request.Header.Set("Content-Type", "application/json")
	response, err := client.Do(request)
	
	if err != nil {
		return err, response.StatusCode
	}
	defer response.Body.Close()
	return nil, response.StatusCode

}