From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Audio mini conference 2014?
Date: Wed, 20 Aug 2014 17:59:27 +0200
Message-ID: <53F4C5DF.4070303@canonical.com>
References: <02884A65-7ADE-4FF3-8552-AD8E73862624@cirrus.com>	<20140807140957.GI8181@intel.com>	<alpine.DEB.2.00.1408121011200.10517@phandrigan-desktop>	<53EA6165.3070902@zonque.org>	<s5hbnropcvd.wl-tiwai@suse.de>	<20140813165517.GB17528@sirena.org.uk>	<20140817231021.GQ14537@sirena.org.uk>	<s5hha1aw6we.wl-tiwai@suse.de>	<20140819172948.GX13288@intel.com>	<alpine.DEB.2.00.1408191451550.10517@phandrigan-desktop>	<20140820042109.GY13288@intel.com>
 <s5hy4ujhfta.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 46008265708
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 17:59:33 +0200 (CEST)
In-Reply-To: <s5hy4ujhfta.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Paul Handrigan <paul.handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On 2014-08-20 07:48, Takashi Iwai wrote:
> - Testing / QA (Takashi)
>    How people do test?  Can we have some automation?

I run automated tests of the HDA codec parser code and has done so for 
quite a while now. Not much has happened the last year, but I can talk 
about it if anyone is interested. (It's a test framework around hda-emu.)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
