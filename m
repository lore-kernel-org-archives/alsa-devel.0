From: Dolevo Jay <cmst@live.com>
Subject: Intermittent cut out on the video
Date: Tue, 26 Nov 2013 16:38:25 +0000
Message-ID: <DUB122-W30D40465C0A432A2147375AAEC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s11.dub0.hotmail.com (dub0-omc3-s11.dub0.hotmail.com
 [157.55.2.20]) by alsa0.perex.cz (Postfix) with ESMTP id 53386260786
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 17:38:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi experts, 

In my system, I use two headphone jacks to connect my speakers, one is to the jack on the pc itself and the other one is to the jack located on the monitor which I connect to the same pc with hdmi cable. I have two sound cards on my system and I use the following asound.conf to have audio from two jacks simultaneously. 
http://pastebin.com/2yd6EW8C

As you see, I also use dmix because I have multiple of audio sources coming and I mix them.

However, I now have the following problem. I connect two speakers to the each jack and start hearing an audio stream. The audio coming from the jack on the pc is cutting out intermittently. It just cuts out for a fraction of a second and continues as normal and after some time it happens again. The frequency of the occurrence increases over time.  I have absolutely no problem with the audio from the jack on the display. 
Could anyone shed some light on this issue? In my opinion, this is a sort of configuration issue since I have no problem at one source while having at the other source.

Thanks in advance,
Regards,

Dolevo




 		 	   		  
