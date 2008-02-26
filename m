From: Dustin Kerstein <dustobub@gmail.com>
Subject: Re: HDA-Intel -  Patch to support RV7xx HDMI Audio
Date: Tue, 26 Feb 2008 14:40:30 +0000 (UTC)
Message-ID: <loom.20080226T143902-240@post.gmane.org>
References: <206C6845C72CAE439DC3D9D413C571A496598E@ssuzexmb3.amd.com>
	<s5hr6ffycp2.wl%tiwai@suse.de>
	<loom.20080225T192638-904@post.gmane.org>
	<s5h8x18uire.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 048DD24340
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 15:40:38 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JU0yy-0003Qt-Fm
	for alsa-devel@alsa-project.org; Tue, 26 Feb 2008 14:40:36 +0000
Received: from cpe-72-231-166-180.nycap.res.rr.com ([72.231.166.180])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 14:40:36 +0000
Received: from dustobub by cpe-72-231-166-180.nycap.res.rr.com with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 14:40:36 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> At Mon, 25 Feb 2008 19:28:12 +0000 (UTC),
> Dustin Kerstein wrote:
> > 
> > Will this patch allow for 8-Channel LPCM audio over HDMI? Thanks.
> 
> No, it's only two channels, equivalent with SPDIF.
> 
> Takashi
> 


How difficult would it be to implement multichannel pcm over HDMI for boards
that specifically support it through the HDMI 1.3 Spec? Thanks.

Dustin
