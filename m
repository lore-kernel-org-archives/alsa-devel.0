From: "Mogens Elneff" <me@netguardians.dk>
Subject: Output from configure
Date: Tue, 7 Sep 2004 11:22:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <95D76FF714D87E4A8BC88A0A2957E48B1440A0@tseappl.tseintern.dk>
Reply-To: "Mogens Elneff (elneff) (E-mail)" <mogens@elneff.dk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tseappl.tseintern.dk (mail.netguardians.dk [194.239.230.24])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0E6E52A5
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 11:15:54 +0200 (MEST)
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.=20

I have downloaded the source by means of cvs and then ran the command: =
"./cvscompile --with-cards=3Dcmipci --with-sequencer=3Dyes". Here below =
are the output.

My kernel is compiled just before this (with the same compiler) and =
running on this new kernel. Is the compiler to new?=20

For info:=20
        I'm running vdr on this PC and need alsa to compile the =
bitstreamout plugin.=20
        I'm a Windows Specialist - but a Linux Newbee - sorry :-)=20

Kind regards=20
Mogens Elneff=20

PS.: "Ingenting at g=F8re for" is danish for "Nothing to do for" ;-)=20


make: Ingenting at g=F8re for 'all-deps'.=20
./configure --with-cards=3Dcmipci --with-sequencer=3Dyes=20
checking for gcc... gcc=20
checking for C compiler default output file name... a.out=20
checking whether the C compiler works... yes=20
checking whether we are cross compiling... no=20
checking for suffix of executables...=20
checking for suffix of object files... o=20
checking whether we are using the GNU C compiler... yes=20
checking whether gcc accepts -g... yes=20
checking for gcc option to accept ANSI C... none needed=20
checking for ranlib... ranlib=20
checking for a BSD-compatible install... /usr/bin/install -c=20
checking how to run the C preprocessor... gcc -E=20
checking for egrep... grep -E=20
checking for ANSI C header files... yes=20
checking for an ANSI C-conforming const... yes=20
checking for inline... inline=20
checking whether time.h and sys/time.h may both be included... yes=20
checking whether gcc needs -traditional... no=20
checking for current directory... /usr/local/src/alsa/alsa-driver=20
checking cross compile...=20
checking for directory with kernel source... =
/lib/modules/2.4.27.vdr2/build=20
checking for kernel version... 2.4.27.vdr2=20
checking for GCC version... Kernel compiler: GCC 3.3.4 (Debian =
1:3.3.4-6sarge1) Used compiler: gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)

Fatal error: Compiler type does not match=20
Decoded kernel compiler: type=3D version=3D3.3.4=20
Decoded used compiler: type=3Dgcc version=3D3.3.4=20
Please, send ./configure output to <alsa-devel@alsa-project.org>=20


  _____ =20

Min mail er beskyttet af SPAMfighter
1513 spam mails er blokeret indtil videre.
Hent gratis SPAMfighter =
<http://www.spamfighter.com/Lang_DA/Product_Info.asp>  i dag!=20


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
