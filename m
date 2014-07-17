From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v3 7/7] ACPI: Cleanup useless ACPI inclusion.
Date: Thu, 17 Jul 2014 01:29:04 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802643042@SHSMSX101.ccr.corp.intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
 <7ac00c9c5a32f7a3ec98f061080ba1573ae57d0d.1405500886.git.lv.zheng@intel.com>
 <20140716120750.GM17528@sirena.org.uk> <4307509.CpjlMkz69H@vostro.rjw.lan>
 <20140716213433.GD17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140716213433.GD17528@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, July 17, 2014 5:35 AM
> 
> On Wed, Jul 16, 2014 at 11:46:14PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 16, 2014 01:07:50 PM Mark Brown wrote:
> > > On Wed, Jul 16, 2014 at 04:59:02PM +0800, Lv Zheng wrote:
> 
> > > > The sst-haswell-dsp.c is an ACPI independent file, this patch removes
> > > > ACPI header files for it.
> 
> > > Applied, thanks.  Please use subject lines matching the style for the
> > > subsystem and send at least the cover letter for the series to everyone
> > > so that they know what's going on with dependencies and so on.
> 
> > Lv thought that this would go through the ACPI tree I suppose.
> 
> Even so the subject line should still line up (it's part of how some of
> us pick out which mail to read).

I just didn't notice this. :-)
I'll take care next time.

Thanks and best regards
-Lv
