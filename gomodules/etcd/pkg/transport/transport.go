// Copyright 2015 The etcd Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package transport

import (
	"crypto/tls"
)


type TLSInfo struct {
	// CertFile is the _server_ cert, it will also be used as a _client_ certificate if ClientCertFile is empty
	CertFile string
	// KeyFile is the key for the CertFile
	KeyFile string

	TrustedCAFile       string
}


// ClientConfig generates a tls.Config object for use by an HTTP client.
func (info TLSInfo) ClientConfig() (*tls.Config, error) {
	return nil, nil
}

func (info TLSInfo) Empty() bool {
	return true
}
