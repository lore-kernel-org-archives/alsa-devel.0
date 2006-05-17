From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-kernel: New ChangeSet 4251:05f8dd80b37c
Date: Wed, 17 May 2006 16:13:09 +0200
Message-ID: <m2k68kpwne.fsf@vador2.mandriva.com>
References: <ALOGGER1147857168.87@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B341D19C
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 16:14:52 +0200 (MEST)
Received: from vador.mandriva.com (unknown [192.168.100.253])
	by office.mandriva.com (Postfix) with ESMTP id BF44254B3E
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 16:14:49 +0200 (CEST)
Received: from vador2.mandriva.com (vador2.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id 3CFAB1BDCE
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 16:13:09 +0200 (CEST)
In-Reply-To: <ALOGGER1147857168.87@alsa-project.org> (Takashi Iwai's message of "Wed, 17 May 2006 11:12:48 +0200 (CEST)")
Sender: alsa-devel-admin@lists.sourceforge.net
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

Takashi Iwai <tiwai@suse.de> writes:

> changeset:   4251:05f8dd80b37c1dd49c8a4189b40fa52b5b1c3c22
> tag:         tip
> user:        tiwai
> date:        Wed May 17 11:04:19 2006 +0200
> files:       pci/azt3328.c
> description:
> azt3328.c: use kernel coding style
> 
> Scope braces were not done the One True Kernel Way.

this is not a real bug per se but anyway:

it would be quite nicer for us poor reader monkeys if the subject
could contain the path of the altered directory (eg: here
alsa-kernel/pci/) like most CVS or SVN commit maillers do.

thanks :-)


btw, it would be better if reply addresses weren't "ALSA HG Logger
<noreply@alsa-project.org>" and "alsa-cvslog@lists.sourceforge.net"
since the former is obviously not to user and the later is probably
limited (at least i supposed it is like in some other projects)

my 2 cents.

see you


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
