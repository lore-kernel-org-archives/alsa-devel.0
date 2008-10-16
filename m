From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 16 Oct 2008 15:09:39 +0400
Message-ID: <20081016150939.c77a8696.baz@irc.msk.ru>
References: <20081012165353.a084d158.baz@irc.msk.ru>
	<s5hod1pz1xl.wl%tiwai@suse.de>
	<20081013165805.735bf06e.baz@irc.msk.ru>
	<s5htzbg63bq.wl%tiwai@suse.de> <48F35C4C.40307@gmail.com>
	<s5hej2k5ysj.wl%tiwai@suse.de> <s5hbpxo5wmw.wl%tiwai@suse.de>
	<s5h1vyk5vr3.wl%tiwai@suse.de> <s5hy70s4h0i.wl%tiwai@suse.de>
	<20081013232147.026f38c9.baz@irc.msk.ru>
	<s5hzll7oetb.wl%tiwai@suse.de>
	<20081015003531.6b96847e.baz@irc.msk.ru>
	<s5hej2iz7yb.wl%tiwai@suse.de>
	<20081015122649.65b32ee4.baz@irc.msk.ru>
	<s5hk5ca2pu1.wl%tiwai@suse.de>
	<20081015225418.ff594f23.baz@irc.msk.ru>
	<s5hk5c83jhp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [62.117.117.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BEAD24528
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 13:10:02 +0200 (CEST)
In-Reply-To: <s5hk5c83jhp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Oct 2008 12:46:42 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 15 Oct 2008 22:54:18 +0400,
> Alexey Bazhin wrote:
> > 
> > > > > Does this happen with aplay, too?
> > Hm... with aplay I'm getting the same thing as "The Source
> > <thesourcehim@gmail.com>" - volume is extremely low and sound is
> > very glitchy. And no error as in speakers-test case. Dmesg included
> > in attachment.
> 
> Which parameters does the WAV file have?
> Is it 16bit, 96kHz, 2 channel?
Yes.

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
