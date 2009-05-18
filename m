From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: Output frequency configuration for I2S in
	beagleboard? (underrun problem)
Date: Mon, 18 May 2009 10:06:40 -0500
Message-ID: <fb44c3530905180806q3e235e75w695637c2952ff414@mail.gmail.com>
References: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
	<200905140916.22937.peter.ujfalusi@nokia.com>
	<fb44c3530905140812u33906301x5e8c46e7258cbb51@mail.gmail.com>
	<200905150923.14187.peter.ujfalusi@nokia.com>
	<fb44c3530905150743i3409d809ldf22ccc903d56144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 14DD1103890
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:06:42 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3450149bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2009 08:06:41 -0700 (PDT)
In-Reply-To: <fb44c3530905150743i3409d809ldf22ccc903d56144@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Finally, we got it working, properly configuring with the clock divide was
the solution. Thanks for your help.

BR,
Ernesto
