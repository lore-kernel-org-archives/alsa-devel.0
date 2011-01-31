From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: patch series to add support for
 capture in mid-x86 and sn95031 codec
Date: Mon, 31 Jan 2011 11:41:07 +0000
Message-ID: <20110131114107.GC5123@opensource.wolfsonmicro.com>
References: <98769532B4BB14429434178695419EAE08C0F3E93E@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C8AE244C8
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 12:41:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C0F3E93E@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 10:08:41PM +0530, Harsha, Priya wrote:

> This patch set adds support for capture in mid-x6 platform, machine and TI
> sn95031 codec drivers.

If you're sending a patch series please ensure that it's threaded with
itself and with the cover letter - git send-email can do this for you.
This is especially important when you're sending multiple serieses at
the same time since otherwise it's harder to figure out which patches
are in which series.

Overall this looks OK.
