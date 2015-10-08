From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Thu, 08 Oct 2015 01:54:01 +0100
Message-ID: <4911294.P8gonaEuuA@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <4761108.z7lHdDqPTH@kamdesktop>
 <4797815.2qQzYzeTe7@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id A241C261531
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 02:54:03 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so6635327wic.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 17:54:03 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id gc8sm4841757wib.2.2015.10.07.17.54.02
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 07 Oct 2015 17:54:02 -0700 (PDT)
In-Reply-To: <4797815.2qQzYzeTe7@kamdesktop>
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

On Thursday 08 Oct 2015 01:51:20 Keith A. Milner wrote:
> On Tuesday 06 Oct 2015 20:58:01 Keith A. Milner wrote:
> > OK, so it seems that this hardware is substantially the same as the GT-100
> > which has previously (and recently) been raised as a problem on ALSA.
> 
> I'm getting somewhere...
> 
> With the following quirk I am getting audio playback with aplay. I have what
> seems like correct MIDI interfaces working (although not fully tested).
> 
> However, recording does not seem to work.

I should add that, by "does not seem to work", the interface is seen, but 
nothing records. When using audacity, for instance, the playhead seems to get 
stuck and doesn't advance.

Cheers,

Keith
