From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mid-x86: Use the soc-jack apis for
 jack type detection
Date: Fri, 11 Feb 2011 11:17:13 +0000
Message-ID: <20110211111712.GA7988@opensource.wolfsonmicro.com>
References: <1297322881-20461-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F5A31037F2
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 12:16:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297322881-20461-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 10, 2011 at 12:58:01PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch modifies the mfld_machine to use the new jack apis for adding the
> voltage zones for jack type detection. It also modifed TI sn95031 codec driver
> to use these new apis

Applied, thanks.
