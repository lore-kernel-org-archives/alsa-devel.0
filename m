From: Andrew Gaydenko <a@etver.com>
Subject: ice1724: from 1.0.4 to 1.0.5a upgrading problem
Date: Wed, 14 Jul 2004 17:18:03 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407141718.03846@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

After upgrading the driver from 1.0.4 to 1.0.5a I'm not able to start jack server
with 96000 rate for alsa driver. I use hw:0,1 device which is digital out in my
Terratek  Aureon Space 7.1. Instead of 96000, jack server starts with 48000. For
hw:0,0 the problem doesn't take place. Can anybody point me further direction to
resolve the problem?

P.S. BTW, 1.0.5a driver has few new mixer controls. What are meaning of
     these controls: 'ADC Oversampling' and 'DAC Deemphasis Switch'?

Andrew


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
