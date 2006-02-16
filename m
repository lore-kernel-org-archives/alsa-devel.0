From: "Mike Gorchak" <lestat@i.com.ua>
Subject: Different volumes on Front/LFE/Center/Surround channels
Date: Thu, 16 Feb 2006 11:24:28 +0200
Message-ID: <dt1gce$6rh$1@sea.gmane.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hello, All!

This question is not for ALSA code :)

It is exist machine with Intel ICH4 + ICEnsemble VT1616i AC'97 codec. When
playing 6-channel wave file (peaks in wave file almost the same for the each
channel) then following picture appears:

1. Front - 100% (let the front be 100%)
2. Surround - appears 45-50% of front volume.
3. Center/LFE - appears 25-30% of front volume.

All mixer settings for the each channel (Front/Surround/Center/LFE) are set
to maximum. But this strange volume reducing on Center/LFE/Surround channels
appearing.

So maybe someone knows this issue and knows how to avoid this ? Personally I
think it is codec issue or mobo issue, but I hope I'm wrong.

With best regards, Mike Gorchak.  E-mail: lestat@i.com.ua





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
