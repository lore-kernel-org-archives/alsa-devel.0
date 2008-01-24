From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Thu, 24 Jan 2008 14:12:35 -0200
Message-ID: <5f52f6d70801240812kf432c74n7de6a960c906f186@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
	<s5h1w8ivvd4.wl%tiwai@suse.de>
	<5f52f6d70801160451p37a8c94ofbbbd2018f88531b@mail.gmail.com>
	<s5hejchvn0e.wl%tiwai@suse.de>
	<5f52f6d70801191119m27f20a6bn3183c44ddb3635bd@mail.gmail.com>
	<s5hfxwre22v.wl%tiwai@suse.de>
	<5f52f6d70801231146m2b668f6yd02df8422d78490d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id A69DA24369
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 17:12:38 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so210023rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 08:12:35 -0800 (PST)
In-Reply-To: <5f52f6d70801231146m2b668f6yd02df8422d78490d@mail.gmail.com>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Marco Schuster <marco@harddisk.is-a-geek.org>
List-Id: alsa-devel@alsa-project.org

On Jan 23, 2008 5:46 PM, Claudio Matsuoka <cmatsuoka@gmail.com> wrote:

> However, hda-config still complains about ioctl
> PVERSION error (ioctl() with HDA_IOCTL_PVERSION returns -1).

Uhm, what device maj/min is hda-config supposed to use?
