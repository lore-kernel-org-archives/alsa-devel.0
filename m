From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: regarding references taken on platform and codec
	driver modules
Date: Mon, 3 Jan 2011 15:54:54 +0000
Message-ID: <20110103155454.GE6783@opensource.wolfsonmicro.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8435824337
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 16:54:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 04:30:35PM +0530, Harsha, Priya wrote:

> Is there anything that I am doing wrong here or missing out?

This should all happen automatically based only on the data structures
in your driver, there shouldn't be anything to miss.
