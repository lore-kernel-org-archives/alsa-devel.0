From: Philipp Mohrenweiser <phiamo@googlemail.com>
Subject: Re:
	=?utf-8?q?Enable_docking_station_speaker_jack_for_ne?=
	=?utf-8?q?w=09Lenovo=09Thinkpads?=
Date: Mon, 6 Aug 2012 09:29:32 +0000 (UTC)
Message-ID: <loom.20120806T101258-620@post.gmane.org>
References: <50170719.8090207@hadiko.de> <s5hsjc7b0ze.wl%tiwai@suse.de>
 <335971331.CJ8quuUl7T@i82pc11> <s5h1ujreywg.wl%tiwai@suse.de>
 <s5hvch2d1ed.wl%tiwai@suse.de> <501996B8.9040609@hadiko.de>
 <s5hk3xhzrua.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A715265B56
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 11:00:02 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SyJdB-0007SV-V0
 for alsa-devel@alsa-project.org; Mon, 06 Aug 2012 11:29:48 +0200
Received: from p5DC16946.dip.t-dialin.net ([93.193.105.70])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 11:29:45 +0200
Received: from phiamo by p5DC16946.dip.t-dialin.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 11:29:45 +0200
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


Hello Mario,
Hello Takashi,

The ways descibed earlier via hda-verb didnt work for my T430s.
Currently i am on Ubuntu 12.04 with a ppa kernel 3.5.0-030500-generic.

Now i am tring to build my own kernel with the patch described for 
sound/pci/hda/patch_realtek.c

but i was wondering where to get the hex for the second argument for 
SND_PCI_QUIRK from?

Can you give me a hint?

Cheers Phil
