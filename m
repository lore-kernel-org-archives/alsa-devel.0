From: Martin Langer <martin-langer@gmx.de>
Subject: National Semiconductor Corporation Open Source License
Date: Sat, 1 Mar 2003 19:26:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030301182634.GA465@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

the ALSA-0.5 Geode Driver (geode.c) on
http://www.gctglobal.com/Download/alsa-geode.tar.gz 
which still waits for a port to 0.9 has the following license, which is not
GPL. Is it really possible to include such a license into the alsa package?
(I see the big problem in the export laws because the kernel is under GPL
without an export rule)

I won't use this code, but I'm definitely no license expert. Or is it possible
to use a different license for a port (IMHO it's more than a modification, but
I don't know the definition of a lawyer in this case)

On the other hand I found another older file in the tgz called geode_BAK.c
without a license text. Same license, no license or GPL for that file?

Or can a port use a dual license (GPL/NSC OSL)?

Anybody there who knows something?


martin



/* NSC_LIC_BSD
 *
 * Revision 1.0.1
 *
 * National Semiconductor Corporation Open Source License for 
 *
 *    Geode Linux ALSA audio driver
 *
 * (BSD License with Export Notice)
 *
 * Copyright (c) July, 2001
 * National Semiconductor Corporation.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions 
 * are met: 
 *
 *   * Redistributions of source code must retain the above copyright 
 *     notice, this list of conditions and the following disclaimer. 
 *
 *   * Redistributions in binary form must reproduce the above 
 *     copyright notice, this list of conditions and the following 
 *     disclaimer in the documentation and/or other materials provided 
 *     with the distribution. 
 *
 *   * Neither the name of the National Semiconductor Corporation nor 
 *     the names of its contributors may be used to endorse or promote 
 *     products derived from this software without specific prior 
 *     written permission. 
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
 * NATIONAL SEMICONDUCTOR CORPORATION OR CONTRIBUTORS BE LIABLE FOR ANY 
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN 
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * EXPORT LAWS: THIS LICENSE ADDS NO RESTRICTIONS TO THE EXPORT LAWS OF 
 * YOUR JURISDICTION. It is licensee's responsibility to comply with 
 * any export regulations applicable in licensee's jurisdiction. Under 
 * CURRENT (July, 2001) U.S. export regulations this software 
 * is eligible for export from the U.S. and can be downloaded by or 
 * otherwise exported or reexported worldwide EXCEPT to U.S. embargoed 
 * destinations which include Cuba, Iraq, Libya, North Korea, Iran, 
 * Syria, Sudan, Afghanistan and any other country to which the U.S. 
 * has embargoed goods and services. 
 *
 * END_NSC_LIC_BSD */


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
