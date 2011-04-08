From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8903: HP and Line out PGA/mixer
	DAPM fixes
Date: Fri, 8 Apr 2011 09:17:36 +0900
Message-ID: <20110408001735.GB9827@opensource.wolfsonmicro.com>
References: <1302196118-17941-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 190C8243EC
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 02:17:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302196118-17941-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, Dilan Lee <dilee@nvidia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2011 at 11:08:38AM -0600, Stephen Warren wrote:
> From: Dilan Lee <dilee@nvidia.com>
> 
> Update the headphone and line out mixers and PGAs use the same logical
> set of register bits and sequencing as the speaker mixer/PGA.

Applied, thanks.
