From: Garett Shulman <shulmang@colorado.edu>
Subject: fluidsynth multiple channels & ladspa
Date: Thu, 05 Feb 2004 17:11:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4022DBC5.8020704@colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fluid-dev@nongnu.org, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Does anybody know if it is possible to get fluidsynth to output 
different instruments on different midi channels to different audio 
channels? For example, I would like to send a piano instrument on midi 
channel 1 out of channels 1 & 2 of the my delta66 and then have a rhodes 
ep on midi channel 2 sent out of channel 3 of the delta66 to an fx 
processor.

Also, is there any means to control ladspa parameters with midi signals 
in fluidsynth?

Thanks for any info.

-Garett


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
