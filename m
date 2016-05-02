From: Caleb Crome <caleb@crome.org>
Subject: ASoC: fsl_sai: Has anybody attempted to run the
 i.MX6UL in TDM mode with channels > 2?
Date: Mon, 2 May 2016 10:52:39 -0700
Message-ID: <CAG5mAdy8BbeKdh+yM8vqNEU1RpzfqD20+SxQj-2iLihXxF7Mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D26A260438
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 19:53:00 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id v145so166493806oie.0
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 10:53:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <festevam@gmail.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Hi all,
   Now that the MX6 fsl_ssi seems to be getting stable for TDM with
channels > 2 (thanks all!), the MX6 UL and MX7 have only the SAI port.

Does anybody have experience with running the SAI with more than 2 channels?

Any thoughts or comments would be welcome!

Thanks,
 -Caleb
