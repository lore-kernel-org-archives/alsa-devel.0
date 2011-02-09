From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: Davinci: Use resource_size()
	helper function
Date: Wed, 09 Feb 2011 21:53:46 +0000
Message-ID: <1297288426.3297.188.camel@odin>
References: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3024B243FF
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:53:50 +0100 (CET)
Received: by wyi11 with SMTP id 11so653832wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:53:50 -0800 (PST)
In-Reply-To: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com, sshtylyov@mvista.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-09 at 18:39 +0530, Vaibhav Bedia wrote:
> This patch modifies the Davinci i2s and mcasp drivers
> to make use of the resource_size() helper function for readability.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
