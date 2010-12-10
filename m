From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: tabs versus space fill
Date: Fri, 10 Dec 2010 13:25:10 -0800
Message-ID: <B2150E1E4418E1438554A300EA5040E40D579D15E8@ITSVLEX06.it.maxim-ic.internal>
References: <1291998221-9642-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam02.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BAFA10380C
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 22:24:50 +0100 (CET)
In-Reply-To: <1291998221-9642-1-git-send-email-jhnikula@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I noticed that in the latest version of the kernel (next), the formatting of the soc sound driver file max98088.c had been changed.  Someone had changed all the tabs to space-fill.  I thought the kernel coding standard encourages the use of tabs.  Is the use of space-fill the new formatting preference for the kernel?

I did not see this patch change on alsa-devel list.  
How do I find out where and when this was changed?

Thanks,

Peter
