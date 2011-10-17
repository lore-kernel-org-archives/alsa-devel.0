From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Mon, 17 Oct 2011 21:15:03 +0100
Message-ID: <20111017201502.GB22941@opensource.wolfsonmicro.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
	<20111007103359.GG19080@opensource.wolfsonmicro.com>
	<1317985636.1573.2272.camel@vkoul-udesk3>
	<20111007114239.GB24534@sirena.org.uk>
	<F41D058E-D2A8-4046-B391-1452889ED54C@cirrus.com>
	<1317997753.1573.2285.camel@vkoul-udesk3>
	<EC6506B9-53FC-40AF-8931-32F07341FD05@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54D97103815
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 22:15:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <EC6506B9-53FC-40AF-8931-32F07341FD05@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<lrg@ti.com>" <lrg@ti.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 17, 2011 at 07:11:39PM +0000, Austin, Brian wrote:

> {"HP Amp", "Switch", "DAC1"},
> {"LO Amp", "Switch", "DAC1"},
> {"SPK Amp", "Switch", "DAC2"},
> {"SPKLO Amp", "Switch", "DAC2"},
> {"EAR Amp", "Switch", "DAC2"},

> This allows me to route the streams from any PCM to any output. IF
> this is OK I would like to resubmit.

This looks reasonable.

[Please fix your mail client to word wrap within paragraphs.]
