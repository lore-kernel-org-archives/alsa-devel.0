From: Julian Sikorski <belegdol@gmail.com>
Subject: speaker volume gets down to 0 and muted
Date: Sat, 17 Nov 2012 17:55:30 +0100
Message-ID: <k88fi0$svo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 12FD6264F07
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2012 17:55:41 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TZlgL-0004xB-Fq
 for alsa-devel@alsa-project.org; Sat, 17 Nov 2012 17:55:49 +0100
Received: from 178-83-207-35.dynamic.hispeed.ch ([178.83.207.35])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2012 17:55:49 +0100
Received: from belegdol by 178-83-207-35.dynamic.hispeed.ch with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2012 17:55:49 +0100
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

Hi,

I have recently noticed this annoying phenomenon: the speaker volume
will get to 0 and muted way more often than I'd like.
I still have not figured out a 100 % reproducer but this is quite
annoying. My system specs:
	
pulseaudio-1.1-9.fc17.x86_64
alsa-lib-1.0.26-1.fc17.x86_64
kernel-3.6.6-1.fc17.x86_64
http://www.alsa-project.org/db/?f=1707d0e40a7a1df7edc71c6c61dcae41e41a8acb

I am eager to receive info on how to debug this further.

Best regards,
Julian
