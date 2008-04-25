From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH 0/3] asoc tlv320aic3x
Date: Fri, 25 Apr 2008 11:17:14 +0200
Message-ID: <20080425091714.GA18478@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A8FFF103830
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:17:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 6388F7F4036
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:17:17 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MfB9VaFO9PID for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:17:15 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

Here are 3 patches regarding the tlv320aic3x driver.

1/3: revisit clock setup and drop dividers table
2/3: add support for GPIO lines
3/3: add more controls to allow cross-mixing

Best regards,
Daniel
