From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH] Revert "ASoC: rockchip: i2s: Support mono capture"
Date: Fri, 26 Jul 2019 20:10:15 +0800
Message-ID: <CAFv8NwLyTPXJ0x9F-wcGM-XFcCp+Nb1s96u9=_2xhs+=Q=E+fw@mail.gmail.com>
References: <20190726044202.26866-1-cychiang@chromium.org> <20190726111717.GB4902@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726111717.GB4902@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, Matthias Kaehlcke <mka@chromium.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2019 at 7:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 12:42:02PM +0800, Cheng-Yi Chiang wrote:
> > This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.
> >
> > Previous discussion in
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
>
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
Hi Mark,
Thank you for the reply.
Fixed the title and commit messages in v2.
