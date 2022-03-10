// Copyright 2016 The etcd Authors
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

package concurrency

import (
	"context"
	"errors"
)

// ErrLocked is returned by TryLock when Mutex is already locked by another session.
var ErrLocked = errors.New("mutex: Locked by another session")
var ErrSessionExpired = errors.New("mutex: session is expired")

// Mutex implements the sync Locker interface with etcd
type Mutex struct {
	// s *Session

	pfx   string
	myKey string
	myRev int64
	// hdr   *pb.ResponseHeader
}

func (m *Mutex) Key() string { return m.myKey }

func (m *Mutex) Unlock(ctx context.Context) error {
	return nil
}


// TryLock locks the mutex if not already locked by another session.
// If lock is held by another session, return immediately after attempting necessary cleanup
// The ctx argument is used for the sending/receiving Txn RPC.
func (m *Mutex) TryLock(ctx context.Context) error {
	return nil
}

// Lock locks the mutex with a cancelable context. If the context is canceled
// while trying to acquire the lock, the mutex tries to clean its stale lock entry.
func (m *Mutex) Lock(ctx context.Context) error {
	return nil
}
