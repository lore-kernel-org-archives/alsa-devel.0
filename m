From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [BUG] Bad decibel data on C-Media USB sound card
Date: Mon, 29 Sep 2014 09:51:52 +0200
Message-ID: <54290F98.3070102@ladisch.de>
References: <CAPMSj_FxRYc8zhf_SBa7phHmRHatj7Y_CQQYpVriCyJsFh0Mag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 35C852605B7
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 09:51:58 +0200 (CEST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id 4B896F8005
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 09:51:12 +0200 (CEST)
In-Reply-To: <CAPMSj_FxRYc8zhf_SBa7phHmRHatj7Y_CQQYpVriCyJsFh0Mag@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Allen M. wrote:
> When the Master channel is lowered below 35% in alsamixer,

What is the value of the "Headphone Playback Volume" mixer control
(as shown by "amixer contents") above and below this threshold?


Regards,
Clemens
