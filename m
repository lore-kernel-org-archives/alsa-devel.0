From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/1] ALSA: hda - add quirk for Thinkpad T430
Date: Fri, 19 Oct 2012 10:00:49 -0700
Message-ID: <20121019170049.GA4787@elie.Belkin>
References: <cover.1350570761.git.joseph.salisbury@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1350570761.git.joseph.salisbury@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joseph.salisbury@canonical.com
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Joseph,

joseph.salisbury@canonical.com wrote:

> [Subject: [PATCH 0/1] ALSA: hda - add quirk for Thinkpad T430]]
[...]
> This patch is to enable audio on T430 Thinkpads.  There is no audo
> from the headphone jack without this patch.  This patch adds a quirk
> for the T430 model.  

Please don't do this cover-letter thing.  A cover letter can be a
good way to *summarize* a long patch series so readers are less
daunted, but any information that was needed to know in order to
evaluate a patch, briefly stated, should be in the commit message that
actually gets committed.

Thanks and hope that helps,
Jonathan
