From: Harald Radke <harryrat@postnuklear.de>
Subject: Re: CORRECTION (get rid of controls with
	snd_ctl_remove)
Date: Mon, 1 Sep 2008 13:09:22 +0200
Message-ID: <200809011309.22478.harryrat@postnuklear.de>
References: <200808291454.42441.harryrat@postnuklear.de>
	<s5hd4jo76k1.wl%tiwai@suse.de>
	<200809011304.45951.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id ACC092415A
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 13:09:22 +0200 (CEST)
In-Reply-To: <200809011304.45951.harryrat@postnuklear.de>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Ok, I just checked my source and  realized I messed things up...

deactivating AND activating work, the control is not accessible via mixer, 
however sound paths the control is related to still are functional

My bad, sorry sorry sorry

Harry
