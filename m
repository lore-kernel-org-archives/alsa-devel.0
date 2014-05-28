From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/5] ASoC: Add ADAU1X61 and ADAU1X81 CODECs
 common code
Date: Wed, 28 May 2014 12:48:47 +0300
Message-ID: <5385B0FF.5030503@linux.intel.com>
References: <1401180801-21260-1-git-send-email-lars@metafoo.de>
 <20140527195553.GG12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EA9F2654DF
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 11:48:51 +0200 (CEST)
In-Reply-To: <20140527195553.GG12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2014 10:55 PM, Mark Brown wrote:
> As ever please try to keep the lines on your commit messages a little 
> shorter.

I ended up adding following into my ~/.vimrc after accidentally creating 
commit message couple times in a wider terminal:

autocmd Filetype gitcommit set textwidth=76

Not sure is that possible to do independently from editor.

-- 
Jarkko
