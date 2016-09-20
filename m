From: xerofoify <xerofoify@gmail.com>
Subject: Oxygen Possible Bug in FCM
Date: Tue, 20 Sep 2016 12:11:08 -0400
Message-ID: <CAPDOMViD16uP7o9nHo16gfvpayev-cY_M_ftBC+4jGdenwjY5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D548526673B
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 18:11:10 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id t83so27434650oie.3
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 09:11:10 -0700 (PDT)
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

Greetings All,
Do anyone known of the best way to test this function,
ac97_fp_rec_volume_put. Seems there may be a bug in
it. I do have the hardware so that's not a issue just wondering what
the different between fp_rec and the standard
get functions are in terms of testing. Further more I am assuming this
has to do with the fp headphones switch
but I don't have headphones that are fp so is there another way to
test this particular function without checking
sound levels.
Cheers,
Nick
