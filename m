From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Virtual Surround, where to start
Date: Thu, 30 Aug 2007 17:56:02 -0400
Message-ID: <75b66ecd0708301456h6be2a0e9oac6f9e46d3f2272a@mail.gmail.com>
References: <12a75e9d0708281744k43079638h8ae6ec1db745e4b7@mail.gmail.com>
	<s5hveay1y1d.wl%tiwai@suse.de>
	<12a75e9d0708301421r7bfbbf8akca9812b45c3ac35@mail.gmail.com>
	<75b66ecd0708301438p173b9862ga0b29227dac4426c@mail.gmail.com>
	<12a75e9d0708301454p15aad4e3udbc59ab52c5f7446@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F140F10393E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 23:56:04 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so716020wag
	for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2007 14:56:03 -0700 (PDT)
In-Reply-To: <12a75e9d0708301454p15aad4e3udbc59ab52c5f7446@mail.gmail.com>
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
To: Colin Nickerson <colin.douglas.nickerson@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/30/07, Colin Nickerson <colin.douglas.nickerson@gmail.com> wrote:
> Ok.  I would like to implement an algorithm like ProLogic II or SRS
> CircleSurround in software for linux so that I do not need to buy a
> receiver.  I have a Revolution 7.1 card.
>

OK so use JACK and write it as a JACK client.

> colin
>
>
>  On 8/30/07, Lee Revell <rlrevell@joe-job.com> wrote:
> > On 8/30/07, Colin Nickerson
> <colin.douglas.nickerson@gmail.com> wrote:
> > > Ok.  Is there anyway to access ASIO with alsa?
> >
> > What are you trying to do?  There's no need for ASIO, ALSA provides
> > the same functionality on Linux that ASIO does on Windows.
> >
> > Lee
> >
>
>
