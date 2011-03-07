From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: New asoc-tools repository
Date: Mon, 7 Mar 2011 16:41:53 +0000
Message-ID: <20110307164153.GA20864@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97E551037F5
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 17:41:55 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi folks,

I've set up a new asoc-tools repository for various tools/scripts
specific to ASoC.  So far I've got two scripts, one for visualizing DAPM
graphs and rendering them to jpeg and another tool for beautifying the
output of the tracepoint hooks of ASoC so that it is more verbose.
Information on how to use these scripts is self-contained in the code.

The repo is at git://opensource.wolfsonmicro.com/asoc-tools.git

Try them out, any feedback is highly appreciated.

Thanks,
Dimitris
