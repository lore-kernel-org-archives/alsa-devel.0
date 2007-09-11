From: owner@bugs.debian.org (Debian Bug Tracking System)
Subject: Bug#428234: marked as done (linux-sound-base: not
 empty so not removed)
Date: Tue, 11 Sep 2007 20:21:07 +0000
Message-ID: <handler.428234.D428234.118954185421335.ackdone@bugs.debian.org>
References: <20070911201728.GT17585@frodo.home.lxtec.de>
	<20070610045818.5861.54596.reportbug@jidanni2.jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1189542067-22754-0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 87EA424454
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:31 +0200 (CEST)
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 55FFE2000067
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:31 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B14513F.dip.t-dialin.net [91.20.81.63])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id DA45216214061
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:30 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVYp4-0007dp-6u
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:30 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4z9ZKX4UnV5 for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:24 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVYot-0007d7-1X
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:19 +0200
Resent-Message-ID: <20070912202818.GE4125@frodo.home.lxtec.de>
Resent-To: alsa-devel <alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>, 428234@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1189542067-22754-0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Your message dated Tue, 11 Sep 2007 22:17:28 +0200
with message-id <20070911201728.GT17585@frodo.home.lxtec.de>
and subject line [Pkg-alsa-devel] Bug#428234: Bug#428234: linux-sound-base:=
 not empty so not removed
has caused the attached Bug report to be marked as done.

This means that you claim that the problem has been dealt with.
If this is not the case it is now your responsibility to reopen the
Bug report if necessary, and/or fix the problem forthwith.

(NB: If you are a system administrator and have no idea what I am
talking about this indicates a serious mail system misconfiguration
somewhere.  Please contact me immediately.)

Debian bug tracking system administrator
(administrator, Debian Bugs database)


------------=_1189542067-22754-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at maintonly) by bugs.debian.org; 10 Jun 2007 05:17:37 +0000
Return-path: <jidanni@jidanni.org>
Received: from frodo.hserus.net ([204.74.68.40])
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1HxFo1-0006PY-6h
	for maintonly@bugs.debian.org; Sun, 10 Jun 2007 05:17:37 +0000
Received: from 122-127-45-234.dynamic.hinet.net ([122.127.45.234]:55877 helo=jidanni2)
	by frodo.hserus.net with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1HxFnj-0007zf-ED by authid <jidanni> with plain
	for <maintonly@bugs.debian.org>; Sat, 09 Jun 2007 22:17:20 -0700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Dan Jacobson <jidanni@jidanni.org>
To: Debian Bug Tracking System <maintonly@bugs.debian.org>
Subject: linux-sound-base: not empty so not removed
Message-ID: <20070610045818.5861.54596.reportbug@jidanni2.jidanni.org>
X-Mailer: reportbug 3.38
Date: Sun, 10 Jun 2007 12:58:18 +0800
Delivered-To: maintonly@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02
	(1.212-2003-09-23-exp) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-9.0 required=4.0 tests=BAYES_00,HAS_PACKAGE
	autolearn=ham version=2.60-bugs.debian.org_2005_01_02

Package: linux-sound-base
Severity: wishlist

dpkg - warning: while removing linux-sound-base, directory `/etc/modutils' not empty so not removed.
dpkg - warning: while removing linux-sound-base, directory `/etc/hotplug' not empty so not removed.
$ find /etc/modutils /etc/hotplug -type f|xargs ls -ogtu
-rwxr-xr-x 1    249 2007-05-24 20:48 /etc/hotplug/usb/libgphoto2
-rwxr-xr-x 1   3907 2007-04-25 22:38 /etc/hotplug/usb/gpsd.hotplug
-rw-r--r-- 1    946 2007-04-25 22:38 /etc/hotplug/usb/gpsd.usermap
-rw-r--r-- 1     97 2006-10-05 21:09 /etc/modutils/apm
-rw-r--r-- 1    309 2006-09-22 23:33 /etc/hotplug/usb.usermap
-rw-r--r-- 1  38952 2006-01-09 00:20 /etc/hotplug/usb.distmap
-rwxr-xr-x 1    528 2006-01-09 00:20 /etc/hotplug/usb/ipaq
-rw-r--r-- 1    252 2005-07-29 03:37 /etc/modutils/ppp
$ find /etc/modutils /etc/hotplug -type f|xargs -n 1 dlocate
$
OK, removing by hand. If you know who they belong to, please clone this bug...


------------=_1189542067-22754-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at 428234-done) by bugs.debian.org; 11 Sep 2007 20:17:34 +0000
X-Spam-Checker-Version: SpamAssassin 3.1.4-bugs.debian.org_2005_01_02
	(2006-07-26) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=4.0 tests=BAYES_00,FORGED_RCVD_HELO,
	HAS_BUG_NUMBER autolearn=no version=3.1.4-bugs.debian.org_2005_01_02
Return-path: <riesebie@lxtec.de>
Received: from smtpout.hostsharing.net ([83.223.95.15])
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1IVCAw-0005Xn-Cf; Tue, 11 Sep 2007 20:17:34 +0000
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 90A83200004A;
	Tue, 11 Sep 2007 22:17:33 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B145E40.dip.t-dialin.net [91.20.94.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 4E96216214088;
	Tue, 11 Sep 2007 22:17:33 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVCAu-000749-I3; Tue, 11 Sep 2007 22:17:32 +0200
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqIT0rUefDVe; Tue, 11 Sep 2007 22:17:28 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVCAq-00073y-QX; Tue, 11 Sep 2007 22:17:28 +0200
Received: from riesebie by frodo.home.lxtec.de with local (Exim 4.68 1 (LXTEC))
	id 1IVCAq-0005Of-Me; Tue, 11 Sep 2007 22:17:28 +0200
Date: Tue, 11 Sep 2007 22:17:28 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
Sender: pkg-alsa-devel-bounces+riesebie=lxtec.de@lists.alioth.debian.org
To: Dan Jacobson <jidanni@jidanni.org>, 428234@bugs.debian.org
Cc: 428234-done@bugs.debian.org
Subject: [Pkg-alsa-devel] Bug#428234: Bug#428234: linux-sound-base: not
	empty so not removed
Message-ID: <20070911201728.GT17585@frodo.home.lxtec.de>
Reply-To: Elimar Riesebieter <riesebie@lxtec.de>,
	428234@bugs.debian.org
References: <20070610045818.5861.54596.reportbug@jidanni2.jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20070610045818.5861.54596.reportbug@jidanni2.jidanni.org>
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
Organization: LXTEC
X-Editor: VIM - Vi IMproved 7.1 (2007 May 12, compiled May 15 2007 21:19:55)
User-Agent: Mutt/1.5.16+lxtec (2007-06-09)

On Sun, 10 Jun 2007 the mental interface of
Dan Jacobson told:

> Package: linux-sound-base
> Severity: wishlist
> 
> dpkg - warning: while removing linux-sound-base, directory `/etc/modutils' not empty so not removed.
> dpkg - warning: while removing linux-sound-base, directory `/etc/hotplug' not empty so not removed.
> $ find /etc/modutils /etc/hotplug -type f|xargs ls -ogtu
> -rwxr-xr-x 1    249 2007-05-24 20:48 /etc/hotplug/usb/libgphoto2
> -rwxr-xr-x 1   3907 2007-04-25 22:38 /etc/hotplug/usb/gpsd.hotplug
> -rw-r--r-- 1    946 2007-04-25 22:38 /etc/hotplug/usb/gpsd.usermap
> -rw-r--r-- 1     97 2006-10-05 21:09 /etc/modutils/apm
> -rw-r--r-- 1    309 2006-09-22 23:33 /etc/hotplug/usb.usermap
> -rw-r--r-- 1  38952 2006-01-09 00:20 /etc/hotplug/usb.distmap
> -rwxr-xr-x 1    528 2006-01-09 00:20 /etc/hotplug/usb/ipaq
> -rw-r--r-- 1    252 2005-07-29 03:37 /etc/modutils/ppp
> $ find /etc/modutils /etc/hotplug -type f|xargs -n 1 dlocate
> $

Try apt-file search /etc/hotplug

> OK, removing by hand. If you know who they belong to, please clone this bug...

Ooooops! Don't do that! /etc/hotplug is a shared dir for your
system. It is true, that removing linux-sound-base won't delete that
dir, if there are other files than installed by alsa-driver reiding
within!

Anyway, this isn't a bug for any Debian package. Closed.

Elimar


-- 
    .~.
    /V\   L   I   N   U   X
   /( )\ >Phear the Penguin<
   ^^-^^


_______________________________________________
Pkg-alsa-devel mailing list
Pkg-alsa-devel@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-alsa-devel



------------=_1189542067-22754-0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------------=_1189542067-22754-0--
