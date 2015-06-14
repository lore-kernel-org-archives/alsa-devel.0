From: Olivier <olivier.pierre@voila.fr>
Subject: Re:
	=?utf-8?q?M-Audio_Midisport_2x2_Anniversary_edition?=
	=?utf-8?q?=2C=09latency=09problem?=
Date: Sun, 14 Jun 2015 19:01:53 +0000 (UTC)
Message-ID: <loom.20150614T205252-433@post.gmane.org>
References: <1430209117.53049092@f91.i.mail.ru>	<1430230406.500088555@f412.i.mail.ru>
 <553FB37B.3000802@ladisch.de> <1430239699.153166263@f195.i.mail.ru>
 <554084BB.1090304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 3432626061E
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 21:05:06 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Z4DDN-0007tg-2X
 for alsa-devel@alsa-project.org; Sun, 14 Jun 2015 21:05:05 +0200
Received: from bve69-1-88-181-228-107.fbx.proxad.net ([88.181.228.107])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 21:05:05 +0200
Received: from olivier.pierre by bve69-1-88-181-228-107.fbx.proxad.net with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 21:05:05 +0200
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



Hello

I think I have similar problem on Debian 8 Jessie, M-Audio Midisport 2x2
Anniversary edition and a synth keyboard. In my case the midi works fine for
a moment but after a moment, the latency is about 5 seconds. GMidi monitor
linked to Jack monitors note events 5 seconds later... I have to plug again
the USB cable to make it work normaly. Did you find an issue to  that?

Olivier
