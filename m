From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] Sound not transferred to docking station after resume from StR
Date: Mon, 19 Apr 2010 16:58:39 +0200
Message-ID: <201004191658.40291.elendil@planet.nl>
References: <201004162131.19171.elendil@planet.nl> <201004191439.45589.elendil@planet.nl> <s5hpr1vob79.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hpr1vob79.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 19 April 2010, Takashi Iwai wrote:
> Thanks for a quick check.  But I found that the patch isn't fully
> correct.
>
> The patch below should suffice instead of the previous one.
> Could you check it again?

Works as well.

Reported-and-tested-by: Frans Pop <elendil@planet.nl>
