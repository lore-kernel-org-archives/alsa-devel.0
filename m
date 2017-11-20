From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 2/7] ASoC: Intel: Kconfig:
 Simplify-clarify ACPI/PCI dependencies
Date: Mon, 20 Nov 2017 16:58:52 +0000
Message-ID: <20171120165852.7492d92c@alans-desktop>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
 <1511024018.25007.310.camel@linux.intel.com>
 <5b2dde66-d30e-5cd6-15df-12f002850274@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fuzix.org (www.llwyncelyn.cymru [82.70.14.225])
 by alsa0.perex.cz (Postfix) with ESMTP id D860F266F52
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 17:58:54 +0100 (CET)
In-Reply-To: <5b2dde66-d30e-5cd6-15df-12f002850274@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

 
> I am aware that Edison could run with a modified 4.4 kernel, I just 
> don't know where the firmware is. I don't see anything for Merrifield in 
> /lib/firmware/intel?

https://downloadmirror.intel.com/25028/eng/edison-image-from-src-package-ww25.5-15.zip

I have no idea why it never made it into the standard Linux firmware
package but with Edison now defunct I also don't have anyone I can ask
about that !

Alan
