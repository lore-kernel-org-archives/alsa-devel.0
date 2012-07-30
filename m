From: Daniel Mack <zonque@gmail.com>
Subject: Re: US Robotics USB Phone
Date: Mon, 30 Jul 2012 16:20:06 +0200
Message-ID: <50169816.8030806@gmail.com>
References: <1Svqhn-2C1hzM0@fwd25.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C1B032652FA
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 16:20:09 +0200 (CEST)
Received: by wgbds1 with SMTP id ds1so2628089wgb.2
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 07:20:10 -0700 (PDT)
In-Reply-To: <1Svqhn-2C1hzM0@fwd25.aul.t-online.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jovanovic.ljubomir@t-online.de" <jovanovic.ljubomir@t-online.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30.07.2012 16:12, jovanovic.ljubomir@t-online.de wrote:
> The file is attached :-) 
> 
> 	Phone works (under winxp) without any driver (speaker and
> microphone), but driver is needed for buttons... 

The device is missing in this lsusb output. I guess you copied only the
visible part of terminal window, and the important pieces have scrolled
away. Run "lsusb >lsusb.txt" and then send the file "lsusb.txt".


Daniel
