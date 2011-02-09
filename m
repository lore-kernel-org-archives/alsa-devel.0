From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Davinci: Use resource_size()
	helper function
Date: Wed, 9 Feb 2011 22:35:46 +0000
Message-ID: <20110209223546.GA13655@opensource.wolfsonmicro.com>
References: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
	<1297288426.3297.188.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA5A11039A5
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 23:35:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297288426.3297.188.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: sshtylyov@mvista.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 09, 2011 at 09:53:46PM +0000, Liam Girdwood wrote:
> On Wed, 2011-02-09 at 18:39 +0530, Vaibhav Bedia wrote:
> > This patch modifies the Davinci i2s and mcasp drivers
> > to make use of the resource_size() helper function for readability.
> > 
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> All
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
