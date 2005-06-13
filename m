From: Tomko <tomko@avantwave.com>
Subject: question : crash between kernel i2c and alsa i2c
Date: Mon, 13 Jun 2005 17:48:32 +0800
Message-ID: <42AD5670.6070900@avantwave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.avantwave.com (mail.avantwave.com [210.17.210.210])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 960F41B4
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 11:48:36 +0200 (MEST)
Received: from [172.16.11.197] ([172.16.11.197])
	by mail.avantwave.com (8.12.10/8.12.10) with ESMTP id j5D9lUsB010871
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 17:47:30 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I know that there is a tiny i2c subsystem inside alsa , i would like to 
know is there any control betwen the kernel i2c subsystem and the alsa 
i2c ?  Will there any crashes if two i2c access the bus togethre ?


Regards,
TOM


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
