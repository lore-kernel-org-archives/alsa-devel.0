From: Cyril Hrubis <metan.lists@gmail.com>
Subject: Re: TASCAM US-122mkII
Date: Fri, 19 Aug 2011 15:11:04 +0200
Message-ID: <20110819131104.GA1913@yumi.suse.cz>
References: <20110819100156.GA31665@yumi>
	<CACTFLANmONgmCtPKFpofJGQ72a5BSbZHkj5+e=yGfDrynDPrQA@mail.gmail.com>
	<20110819113727.GA9522@yumi>
	<CACTFLAPnWpq7AQ3KZakqkLRV7CtgDG-fXM77T9NLK5o90hfxzA@mail.gmail.com>
	<1313759213.3673.40.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 27D57246A0
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 15:11:03 +0200 (CEST)
Received: by fxh10 with SMTP id 10so2102001fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 06:11:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313759213.3673.40.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!
> > > As far as I understand it, there are two endpoints for audio and two for
> > > MIDI. The MIDI part seems to be initalized fine although I don't have
> > > any MIDI device to test it.
> > >
> > > And in the log from windows machine the audio part does some
> > > intialization and then only buch of isochronous transfers.
> > 
> > Hmm, so it seems that our only option is really to look at these
> > Windows dumps and reverse-engineer the protocol.
> 
> Is there a chance to talk to the manufacturer or are they known to not
> cooperate? Cyril, did you contact their support?

Hmm, haven't though of this, but that may be worth of try.

-- 
Cyril Hrubis
