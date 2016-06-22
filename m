From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/2] ASoC: da7219: Convert driver to use generic FW functions
Date: Wed, 22 Jun 2016 03:05:26 +0200
Message-ID: <CAJZ5v0g47+igo+Z+gZZE9sOix8oCs7Jy+H-i=HcBUB+RVib3+g@mail.gmail.com>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
 <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com> <2E89032DDAA8B9408CB92943514A0337D4644644@SW-EX-MBX01.diasemi.com>
 <20160621232116.GG28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621232116.GG28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Sathyanarayana Nujella <sathyanarayana.nujella-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2016 at 1:21 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 21, 2016 at 10:54:39PM +0000, Opensource [Adam Thomson] wrote:
>> On 21 June 2016 23:30, Rafael J. Wysocki wrote:
>
>> > I'm fine with the first patch and the second one carries a couple of
>> > ACKs already, so do you want me to apply them both?
>
> None of whom are from anyone who works on the subsystem at all!  I've
> not looked at the patch yet.
>
>> Thanks Rafael. I think we still need Mark's Ack for the ASoC codec changes
>> though before we can proceed.
>
> Probably the easiest thing would be a tag for the core change that I can
> pull.

Or you can apply them both if that helps (please consider the first
one as ACKed in that case).
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
