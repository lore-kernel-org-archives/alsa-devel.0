From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: Building alsa with kernel 2.6 when O= option used.
Date: Sun, 25 Jul 2004 19:56:27 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040725195633.16610.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bigblen@icqmail.com
Cc: eliot@blennerhassett.gen.nz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well it seems I am talking to myself here... and so I shall continue.

The only way I have got alsa 1.0.5 driver to compile as an ordinary user is to
get my own copy of the source tree, configure and build that, then continue to
build the alsa driver.

Following the instructions here helped
	http://alsa.opensrc.org/index.php?page=AlsaBuild2.6

So I am on my way again, but I still think there is a bug in the build system
that doesn't allow for Alsa build to work with "O=<path to my dir" kernel
builds. I.e. avoiding taking an actual copy of the whole kernel source tree into
<path to my dir>

regards

Eliot


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
