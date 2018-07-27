/*******************************************************************************
 * Copyright (c) 2006 International Business Machines Corporation.             *
 * All rights reserved. This program and the accompanying materials            *
 * are made available under the terms of the Common Public License v1.0        *
 * which accompanies this distribution, and is available at                    *
 * http://www.opensource.org/licenses/cpl1.0.php                               *
 *                                                                             *
 * Contributors:                                                               *
 *    Douglas M. Pase - initial API and implementation                         *
 *    Tim Besard - prefetching, JIT compilation                                *
 *******************************************************************************/

//
// Configuration
//

// Implementation header
#include "lock.h"

// System includes
#include <cstdio>

#include "defs.h" //jgw//

//
// Implementation
//

Lock::Lock() {
#ifdef PTHREAD
	pthread_mutex_init(&(this->mutex), NULL);
#endif
}

Lock::~Lock() {
#ifdef PTHREAD
	pthread_mutex_destroy(&(this->mutex));
#endif
}

void Lock::lock() {
#ifdef PTHREAD
	pthread_mutex_lock(&(this->mutex));
#endif
}

int Lock::test() {
#ifdef PTHREAD
	return pthread_mutex_trylock(&(this->mutex));
#else
	return 0;
#endif
}

void Lock::unlock() {
#ifdef PTHREAD
	pthread_mutex_unlock(&(this->mutex));
#endif
}

