From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Date: Thu, 1 Feb 2018 16:46:56 +0200
Message-ID: <CAHp75VfydH+9ABZRbV++Od3+wnvQdzXyyDFtfi-1FnOUYjOXQQ@mail.gmail.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
 <1517475954.8615.18.camel@nxp.com> <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
 <20180201134840.GA10785@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180201134840.GA10785-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>, Cosmin Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org" <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>, "mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "S.j. Wang" <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mihai.serban-3arQi8VN3Tc@public.gmane.org" <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 1, 2018 at 3:48 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Feb 01, 2018 at 03:20:38PM +0200, Andy Shevchenko wrote:
>> On Thu, Feb 1, 2018 at 11:05 AM, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org> wrote:
>
>> >> > Signed-off-by: Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>
>> >> > Signed-off-by: Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
>> >> > Signed-off-by: Shengjiu Wang <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>
>> >> > Signed-off-by: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
>> >> 4 authors of the code?!
>
>> > The code has a very long history. I will add under each SoB the specific
>> > contribution.
>
>> > Mihai got the code from Junichi and reworked it for 4.9. Then Shengjiu and
>> > me added various features and cleanups.
>
>> > Any other suggestion?
>
>> Yes, please, put detailed credits in commit message to not shock
>> people with so many SoB w/o explanation why.
>
> Honestly the signoffs above are nothing unusual for a driver contributed
> by a vendor - things are often bouncing around internally for ages and
> it's good to keep credits for people.

We have Co-developed-by: for the authors.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
