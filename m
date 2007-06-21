From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: OSS/4Front
Date: Wed, 20 Jun 2007 18:47:45 -0700
Message-ID: <1182390465.15219.229.camel@razman.gruemaster.com>
References: <20070621012308.C0A1816427C@ws1-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 2717E24420
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 03:47:47 +0200 (CEST)
In-Reply-To: <20070621012308.C0A1816427C@ws1-4.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In reviewing the GPL2 version of their code, I can't see any benefits to
the Intel HD Audio code base.  I'll build and test it to see if there is
any improvements, but I'm doubting it.  There are no widget controls
specific to each chip.

Tobin

On Wed, 2007-06-20 at 20:23 -0500, Ash Willis wrote:

> Hi,
> Does anyone know if there's any kind of list showing a comparison of
> hardware support between ALSA and OSS/4Front?
> 
> With the recent open sourcing of OSS, it would be nice to port code
> to ALSA for devices that are only currently covered by OSS. There
> has to be at least a few devices that we can grab support for, right?
> It may at least provide us with insight into a few bugfixes.
> 
> Ash
> 

-- 
Tobin Davis <tdavis@dsl-only.net>
