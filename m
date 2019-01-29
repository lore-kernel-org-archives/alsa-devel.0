From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
Date: Tue, 29 Jan 2019 14:54:26 +0800
Message-ID: <CAFv8NwJfovuFmRiOctGxoGLBR=pZCPSBUkPztMhVubYTugHppg@mail.gmail.com>
References: <20181226070317.72022-1-cychiang@chromium.org> <20190107192402.GW9570@sirena.org.uk>
 <20190108095450.GA27286@dell> <20190108161238.GG6590@sirena.org.uk>
 <CAFv8NwK4=m1ffsyTruMPw534FVK6QBeaMKxxW461aS_yNYugNg@mail.gmail.com> <20190128065030.GA4678@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128065030.GA4678@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 28, 2019 at 2:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 28 Jan 2019, Cheng-yi Chiang wrote:
>
> > Hi Lee,
> >   Could you please give Mark a tag so he can merge ?
> > The later patch for cros_ec_codec driver is pending on it.
>
> Apologies for not getting back to you.
>
> I was waiting to see if my late PR would be merged.
>
> It was, which means the tag you were asking for is actually upstream.
>
> Any issues, let me know.

Hi Lee,
  Thanks for the reply. I see. Yes it was merged in upstream:
c1f3375be60c mfd: cros_ec: Add commands to control codec

Hi Mark,
  I am not sure what would be the best practice for you.
Would it work if you cherrypick this patch from upstream into your branch ?

Thanks!


>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
