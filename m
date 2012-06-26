From: Zhen Fu <fuzh@marvell.com>
Subject: how to update hw_ptr and appl_ptr
Date: Mon, 25 Jun 2012 22:40:09 -0700
Message-ID: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog132.obsmtp.com (na3sys009aog132.obsmtp.com
	[74.125.149.250])
	by alsa0.perex.cz (Postfix) with ESMTP id A31F924AE1
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 07:41:28 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Zhen Fu <fuzh@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi developer,

I recently look the function snd_pcm_update_hw_ptr0 want to  find how to update status->hw_ptr and control->appl_ptr. If you have to know this, can you tell me? Thank you very much.

--
Best Regards,
Zhen Fu
