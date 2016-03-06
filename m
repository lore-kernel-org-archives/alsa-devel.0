From: JB Fonder <jbfonder@yahoo.fr>
Subject: Re: Trouble about Roland UA-55 and snd-usb-audio module
Date: Sun, 6 Mar 2016 23:03:32 +0000 (UTC)
Message-ID: <loom.20160307T000320-379@post.gmane.org>
References: <50A349A5.6010403@firebuntu.com> <50A34C36.7080506@ladisch.de>
 <50A56FE6.3050009@firebuntu.com> <loom.20130109T124035-460@post.gmane.org>
 <50FC3009.9070401@ladisch.de> <loom.20130125T202229-943@post.gmane.org>
 <loom.20130128T221942-836@post.gmane.org> <5106F107.90704@ladisch.de>
 <loom.20130131T042847-100@post.gmane.org> <51140FFD.3060907@ladisch.de>
 <5114F5D6.4070404@ladisch.de> <BLU0-SMTP3373EB4C32D8FE75E0B686A7F90@phx.gbl>
 <loom.20160229T110434-826@post.gmane.org> <56D83817.8010204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 376A8260592
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 00:15:09 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1acht9-0008Q5-D8
 for alsa-devel@alsa-project.org; Mon, 07 Mar 2016 00:15:03 +0100
Received: from 84.238.31.109.rev.sfr.net ([109.31.238.84])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2016 00:15:03 +0100
Received: from jbfonder by 84.238.31.109.rev.sfr.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2016 00:15:03 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> Jeroen Kransen wrote:
> > Hello, what is the status of the support for the UA-55?
> 
> As far as I know, it was supported once at a time, but some later change
> in the driver broke it for some unknown reason.
> 
> Regards,
> Clemens
> 


Hi all,

I can confirm this. 
I'm a QUAD CAPTURE user and it was working until the last week. A few
updates later and it does not work anymore :-( ...
It is listed in lsusb but in alsamixer it says "this sound device does not
have any controls". It's incredibly frustrating!

JBF
