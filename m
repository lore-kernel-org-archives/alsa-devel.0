From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fixes to McASP configuration
Date: Fri, 18 Sep 2009 15:08:50 +0100
Message-ID: <20090918140849.GA854@rakim.wolfsonmicro.main>
References: <1253052809-24547-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB353243DD
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 16:08:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253052809-24547-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 15, 2009 at 06:13:29PM -0400, Chaithrika U S wrote:
> McASP register settings are not correct for DSP mode of operation.
> There is a channel swap initally. This patch provides fixes to
> the register values for proper working.

> Tested on DA830/OMAP-L137 EVM, DM6467 EVM.

> Signed-off-by: Chaithrika U S <chaithrika@ti.com>

Applied now - thanks!
