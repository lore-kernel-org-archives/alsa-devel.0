From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Date: Wed, 22 May 2019 06:53:06 +0100
Message-ID: <20190522055306.GC4574@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
 <20190518063949.GY4319@dell>
 <20190521174438.GA2821@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521174438.GA2821@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@google.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 21 May 2019, Benson Leung wrote:

> Hi Lee,
> 
> On Sat, May 18, 2019 at 07:39:49AM +0100, Lee Jones wrote:
> > On Fri, 17 May 2019, Gwendal Grignou wrote:
> > 
> > > Lee,
> > > 
> > > I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> > > used on chromebook using a squashed version of these patches.
> > > (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> > > respectively)
> > > Please let me know if you have any questions.
> > 
> > Is no one else from Chromium going to review?
> > 
> > These seem like quite important changes.
> > 
> 
> I've gone ahead and acked the whole series. Enric and I are OK with this going
> in for 5.3, and as Gwendal mentioned, he's landed these changes into our
> production kernels for Chrome OS as well, so this is what we want to sync on.

Wonderful, thank you.

> Let me know if you have any other concerns.
> 
> Thanks,
> Benson
> 



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
