From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 7/7] ACPI: Cleanup useless ACPI inclusion.
Date: Wed, 16 Jul 2014 23:46:14 +0200
Message-ID: <4307509.CpjlMkz69H@vostro.rjw.lan>
References: <cover.1387336613.git.lv.zheng@intel.com> <7ac00c9c5a32f7a3ec98f061080ba1573ae57d0d.1405500886.git.lv.zheng@intel.com> <20140716120750.GM17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140716120750.GM17528@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday, July 16, 2014 01:07:50 PM Mark Brown wrote:
> 
> --5me2qT3T17SWzdxI
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Wed, Jul 16, 2014 at 04:59:02PM +0800, Lv Zheng wrote:
> > The sst-haswell-dsp.c is an ACPI independent file, this patch removes
> > ACPI header files for it.
> 
> Applied, thanks.  Please use subject lines matching the style for the
> subsystem and send at least the cover letter for the series to everyone
> so that they know what's going on with dependencies and so on.

Lv thought that this would go through the ACPI tree I suppose.

Rafael

