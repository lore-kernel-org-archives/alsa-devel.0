From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fail codec probe if we fail to
	add controls
Date: Wed, 2 Apr 2014 09:29:40 +0100
Message-ID: <20140402082939.GA23949@opensource.wolfsonmicro.com>
References: <20140401125933.GA25844@opensource.wolfsonmicro.com>
 <20140401160311.GZ2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71CDD2654D5
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 10:29:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140401160311.GZ2269@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 01, 2014 at 05:03:11PM +0100, Mark Brown wrote:
> On Tue, Apr 01, 2014 at 01:59:33PM +0100, Nariman Poushin wrote:
> > Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> 
> Applied, but:
> 
> Applying: ASoC: core: Fail codec probe if we fail to add controls
> /home/broonie/git/linux/.git/rebase-apply/patch:19: space before tab in
> indent.
> 					  	driver->num_dapm_widgets);
> /home/broonie/git/linux/.git/rebase-apply/patch:20: trailing whitespace.
> 		
> please run checkpatch.

Will make sure to do in future, sorry for to the oversight.
